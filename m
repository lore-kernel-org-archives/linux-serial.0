From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: ns16550 earlycon baud broken on BCM5301X since commit 31cb9a8575ca0
 ("earlycon: initialise baud field of earlycon device structure")
Date: Thu, 29 Mar 2018 14:34:46 +0200
Message-ID: <CACna6rzki=sjXQS12eF3yPXH7XeFYTCXVOdj--F=P=jkJZX7fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="00000000000059390a05688c593a"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

--00000000000059390a05688c593a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I upgraded my BCM5301X device based on BCM4708 SoC from 4.13 to 4.14
and noticed earlycon output is corrupted (a wrong baud rate is used).


I bisected this problem down to the:

commit 31cb9a8575ca04f47ea113434d4782b695638b62
Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Date:   Mon Aug 21 19:22:13 2017 +0300

    earlycon: initialise baud field of earlycon device structure


My device uses arch/arm/boot/dts/bcm4708.dtsi:

uart0: serial@0300 {
        compatible =3D "ns16550";
        reg =3D <0x0300 0x100>;
        interrupts =3D <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
        clocks =3D <&iprocslow>;
        status =3D "okay";
};

aliases {
        serial0 =3D &uart0;
};

chosen {
        stdout-path =3D "serial0:115200n8";
};


A valid UART divisor for my device is 54. This is what bootloader sets
and what works with my serial console running 115200 8n1.


Before the commit 31cb9a8575ca0 early_serial8250_setup() never tried
setting baud because device->baud was 0. It left baud (divisor) to
whatever was configured by the bootloader. It has changed with above
commit though. So now the setup looks like that:
1) port->uartclk equals 1843200 as set in the of_setup_earlycon():
port->uartclk =3D BASE_BAUD * 16;
2) [NEW] device->baud equals 115200 as set in the of_setup_earlycon():
early_console_dev.baud =3D simple_strtoul(options, NULL, 0);
(a value of options is "115200n8")
3) [NEW] divisor is calculated to 1 in the init_port():
divisor =3D DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
4) [NEW] divisor is set using UART_DLL and UART_DLM in the init_port()

Obviously setting divisor 1 instead of 54 results in a wrong baud.


So right now my serial console output looks like that:
=EF=BF=BD6;'+{.=EF=BF=BD=EF=BF=BDs=EF=BF=BD.=EF=BF=BD=EF=BF=BD=EF=BF=BD.".=
=EF=BF=BD=EF=BF=BD4=EF=BF=BD=EF=BF=BD.=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD.=EF=BF=BD=EF=BF=BDJ|=EF=BF=BD.=EF=BF=BD.8=EF=BF=BD=EF=BF=BD.=EF=
=BF=BD..=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDg=EF=BF=BD=EF=
=BF=BD~.=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDL>.=EF=BF=BD=EF=BF=BD,=EF=BF=BD=
9z9=EF=BF=BD{=EF=BF=BDZ=EF=BF=BD.."=EF=BF=BD=EF=BF=BD=EF=BF=BDNC=EF=BF=BD<=
=EF=BF=BD9.=EF=BF=BD/=EF=BF=BD=EF=BF=BD=EF=BF=BD.=EF=BF=BD.=EF=BF=BD}=EF=BF=
=BD=EF=BF=BD~.=EF=BF=BD=EF=BF=BD=EF=BF=BD"=EF=BF=BD.=EF=BF=BD|=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD;?=EF=BF=BD.=EF=BF=BD=EF=BF=BDyy=EF=BF=BD.[
   0.043623] console [ttyS0] enabled
[    0.043623] console [ttyS0] enabled
[    0.050842] bootconsole [ns16550] disabled
[    0.050842] bootconsole [ns16550] disabled
[    0.062939] libphy: Fixed MDIO Bus: probed
(...)

For a complete log (coming from dmesg command) see attachment.


Can you take a look at this problem, please? Is there something wrong
with my DT? Or is a problem in 8250 or earlycon?

--=20
Rafa=C5=82

--00000000000059390a05688c593a
Content-Type: text/plain; charset="UTF-8"; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfchno510

WyAgICAwLjAwMDAwMF0gQm9vdGluZyBMaW51eCBvbiBwaHlzaWNhbCBDUFUgMHgwClsgICAgMC4w
MDAwMDBdIHJhbmRvbTogZ2V0X3JhbmRvbV9ieXRlcyBjYWxsZWQgZnJvbSBzdGFydF9rZXJuZWwr
MHgyOC8weDNhOCB3aXRoIGNybmdfaW5pdD0wClsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNpb24g
NC4xMy4wLXJjNSsgKHphamVjQGxpbnV4LXNhbXN1bmcubGFuKSAoZ2NjIHZlcnNpb24gNy4zLjAg
KE9wZW5XcnQgR0NDIDcuMy4wIHI2NDI3KzEtZWQzODYwYzNlMykpICMwIFNNUCBUdWUgTWFyIDI3
IDA5OjMzOjUxIDIwMTgKWyAgICAwLjAwMDAwMF0gQ1BVOiBBUk12NyBQcm9jZXNzb3IgWzQxM2Zj
MDkwXSByZXZpc2lvbiAwIChBUk12NyksIGNyPTEwYzUzODdkClsgICAgMC4wMDAwMDBdIENQVTog
UElQVCAvIFZJUFQgbm9uYWxpYXNpbmcgZGF0YSBjYWNoZSwgVklQVCBhbGlhc2luZyBpbnN0cnVj
dGlvbiBjYWNoZQpbICAgIDAuMDAwMDAwXSBPRjogZmR0OiBNYWNoaW5lIG1vZGVsOiBMdXh1bCBY
QVAtMTUxMCBWMQpbICAgIDAuMDAwMDAwXSBlYXJseWNvbjogbnMxNjU1MCBhdCBNTUlPIDB4MTgw
MDAzMDAgKG9wdGlvbnMgJzExNTIwMG44JykKWyAgICAwLjAwMDAwMF0gYm9vdGNvbnNvbGUgW25z
MTY1NTBdIGVuYWJsZWQKWyAgICAwLjAwMDAwMF0gTWVtb3J5IHBvbGljeTogRGF0YSBjYWNoZSB3
cml0ZWFsbG9jClsgICAgMC4wMDAwMDBdIEhpdCBwZW5kaW5nIGFzeW5jaHJvbm91cyBleHRlcm5h
bCBhYm9ydCAoRlNSPTB4MDAwMDFjMDYpIGR1cmluZyBmaXJzdCB1bm1hc2ssIHRoaXMgaXMgbW9z
dCBsaWtlbHkgY2F1c2VkIGJ5IGEgZmlybXdhcmUvYm9vdGxvYWRlciBidWcuClsgICAgMC4wMDAw
MDBdIHBlcmNwdTogRW1iZWRkZWQgMTQgcGFnZXMvY3B1IEBjN2VkNDAwMCBzMjY1NzIgcjgxOTIg
ZDIyNTgwIHU1NzM0NApbICAgIDAuMDAwMDAwXSBCdWlsdCAxIHpvbmVsaXN0cyBpbiBab25lIG9y
ZGVyLCBtb2JpbGl0eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiAzMjUxMgpbICAgIDAuMDAw
MDAwXSBLZXJuZWwgY29tbWFuZCBsaW5lOiBjb25zb2xlPXR0eVMwLDExNTIwMCBlYXJseWNvbgpb
ICAgIDAuMDAwMDAwXSBQSUQgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyOiAtMSwgMjA0
OCBieXRlcykKWyAgICAwLjAwMDAwMF0gRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczog
MTYzODQgKG9yZGVyOiA0LCA2NTUzNiBieXRlcykKWyAgICAwLjAwMDAwMF0gSW5vZGUtY2FjaGUg
aGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjogMywgMzI3NjggYnl0ZXMpClsgICAgMC4w
MDAwMDBdIE1lbW9yeTogMTIzMjA0Sy8xMzEwNzJLIGF2YWlsYWJsZSAoNDA5Nksga2VybmVsIGNv
ZGUsIDExMEsgcndkYXRhLCA4MTZLIHJvZGF0YSwgMTAyNEsgaW5pdCwgMjkzSyBic3MsIDc4NjhL
IHJlc2VydmVkLCAwSyBjbWEtcmVzZXJ2ZWQsIDBLIGhpZ2htZW0pClsgICAgMC4wMDAwMDBdIFZp
cnR1YWwga2VybmVsIG1lbW9yeSBsYXlvdXQ6ClsgICAgMC4wMDAwMDBdICAgICB2ZWN0b3IgIDog
MHhmZmZmMDAwMCAtIDB4ZmZmZjEwMDAgICAoICAgNCBrQikKWyAgICAwLjAwMDAwMF0gICAgIGZp
eG1hcCAgOiAweGZmYzAwMDAwIC0gMHhmZmYwMDAwMCAgICgzMDcyIGtCKQpbICAgIDAuMDAwMDAw
XSAgICAgdm1hbGxvYyA6IDB4Yzg4MDAwMDAgLSAweGZmODAwMDAwICAgKCA4ODAgTUIpClsgICAg
MC4wMDAwMDBdICAgICBsb3dtZW0gIDogMHhjMDAwMDAwMCAtIDB4YzgwMDAwMDAgICAoIDEyOCBN
QikKWyAgICAwLjAwMDAwMF0gICAgIHBrbWFwICAgOiAweGJmZTAwMDAwIC0gMHhjMDAwMDAwMCAg
ICggICAyIE1CKQpbICAgIDAuMDAwMDAwXSAgICAgbW9kdWxlcyA6IDB4YmYwMDAwMDAgLSAweGJm
ZTAwMDAwICAgKCAgMTQgTUIpClsgICAgMC4wMDAwMDBdICAgICAgIC50ZXh0IDogMHhjMDAwODAw
MCAtIDB4YzA1MDAwMDAgICAoNTA4OCBrQikKWyAgICAwLjAwMDAwMF0gICAgICAgLmluaXQgOiAw
eGMwNjAwMDAwIC0gMHhjMDcwMDAwMCAgICgxMDI0IGtCKQpbICAgIDAuMDAwMDAwXSAgICAgICAu
ZGF0YSA6IDB4YzA3MDAwMDAgLSAweGMwNzFiYTQwICAgKCAxMTEga0IpClsgICAgMC4wMDAwMDBd
ICAgICAgICAuYnNzIDogMHhjMDcxYmE0MCAtIDB4YzA3NjUxNGMgICAoIDI5NCBrQikKWyAgICAw
LjAwMDAwMF0gU0xVQjogSFdhbGlnbj02NCwgT3JkZXI9MC0zLCBNaW5PYmplY3RzPTAsIENQVXM9
MiwgTm9kZXM9MQpbICAgIDAuMDAwMDAwXSBIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0aW9u
LgpbICAgIDAuMDAwMDAwXSBOUl9JUlFTOiAxNiwgbnJfaXJxczogMTYsIHByZWFsbG9jYXRlZCBp
cnFzOiAxNgpbICAgIDAuMDAwMDAwXSBMMkMtMzEwIGNhY2hlIGNvbnRyb2xsZXIgZW5hYmxlZCwg
MTYgd2F5cywgMjU2IGtCClsgICAgMC4wMDAwMDBdIEwyQy0zMTA6IENBQ0hFX0lEIDB4NDEwMDAw
YzgsIEFVWF9DVFJMIDB4MGExMzAwMDAKWyAgICAwLjAwMDAxN10gc2NoZWRfY2xvY2s6IDY0IGJp
dHMgYXQgNDAwTUh6LCByZXNvbHV0aW9uIDJucywgd3JhcHMgZXZlcnkgNDM5ODA0NjUxMTEwM25z
ClsgICAgMC4wMDg1MzZdIGNsb2Nrc291cmNlOiBhcm1fZ2xvYmFsX3RpbWVyOiBtYXNrOiAweGZm
ZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczogMHg1YzQwOTNhN2QxLCBtYXhfaWRsZV9uczogNDQw
Nzk1MjEwNjM1IG5zClsgICAgMC4wMjAyODhdIFN3aXRjaGluZyB0byB0aW1lci1iYXNlZCBkZWxh
eSBsb29wLCByZXNvbHV0aW9uIDJucwpbICAgIDAuMDI2OTAyXSBDYWxpYnJhdGluZyBkZWxheSBs
b29wIChza2lwcGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1lciBmcmVxdWVuY3kuLiA4
MDAuMDAgQm9nb01JUFMgKGxwaj00MDAwMDAwKQpbICAgIDAuMDM4NDY4XSBwaWRfbWF4OiBkZWZh
dWx0OiAzMjc2OCBtaW5pbXVtOiAzMDEKWyAgICAwLjA0MzYwOV0gTW91bnQtY2FjaGUgaGFzaCB0
YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlcjogMCwgNDA5NiBieXRlcykKWyAgICAwLjA1MDY2OF0g
TW91bnRwb2ludC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyOiAwLCA0MDk2
IGJ5dGVzKQpbICAgIDAuMDU4OTYzXSBDUFU6IFRlc3Rpbmcgd3JpdGUgYnVmZmVyIGNvaGVyZW5j
eTogb2sKWyAgICAwLjA2NDU0MV0gQ1BVMDogdGhyZWFkIC0xLCBjcHUgMCwgc29ja2V0IDAsIG1w
aWRyIDgwMDAwMDAwClsgICAgMC4wNzExMjVdIFNldHRpbmcgdXAgc3RhdGljIGlkZW50aXR5IG1h
cCBmb3IgMHgxMDAwMDAgLSAweDEwMDAzYwpbICAgIDAuMDc3OTUwXSBIaWVyYXJjaGljYWwgU1JD
VSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjA4MzE3N10gc21wOiBCcmluZ2luZyB1cCBzZWNvbmRh
cnkgQ1BVcyAuLi4KWyAgICAwLjA4ODkzNF0gQ1BVMTogdGhyZWFkIC0xLCBjcHUgMSwgc29ja2V0
IDAsIG1waWRyIDgwMDAwMDAxClsgICAgMC4wODkwNjFdIHNtcDogQnJvdWdodCB1cCAxIG5vZGUs
IDIgQ1BVcwpbICAgIDAuMDk5NTI5XSBTTVA6IFRvdGFsIG9mIDIgcHJvY2Vzc29ycyBhY3RpdmF0
ZWQgKDE2MDAuMDAgQm9nb01JUFMpLgpbICAgIDAuMTA2MzE1XSBDUFU6IFdBUk5JTkc6IENQVShz
KSBzdGFydGVkIGluIHdyb25nL2luY29uc2lzdGVudCBtb2RlcyAocHJpbWFyeSBDUFUgbW9kZSAw
eDEzKQpbICAgIDAuMTE1MzQ2XSBDUFU6IFRoaXMgbWF5IGluZGljYXRlIGEgYnJva2VuIGJvb3Rs
b2FkZXIgb3IgZmlybXdhcmUuClsgICAgMC4xMjQxODZdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBt
YXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiAxOTEx
MjYwNDQ2Mjc1MDAwMCBucwpbICAgIDAuMTM0NzYxXSBmdXRleCBoYXNoIHRhYmxlIGVudHJpZXM6
IDUxMiAob3JkZXI6IDMsIDMyNzY4IGJ5dGVzKQpbICAgIDAuMTQxNDIxXSBwaW5jdHJsIGNvcmU6
IGluaXRpYWxpemVkIHBpbmN0cmwgc3Vic3lzdGVtClsgICAgMC4xNDc0OThdIE5FVDogUmVnaXN0
ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYKWyAgICAwLjE1MzAyNl0gRE1BOiBwcmVhbGxvY2F0ZWQg
MjU2IEtpQiBwb29sIGZvciBhdG9taWMgY29oZXJlbnQgYWxsb2NhdGlvbnMKWyAgICAwLjE2MjM3
MF0gcmFuZG9tOiBmYXN0IGluaXQgZG9uZQpbICAgIDAuMTc1MjIzXSBjbG9ja3NvdXJjZTogU3dp
dGNoZWQgdG8gY2xvY2tzb3VyY2UgYXJtX2dsb2JhbF90aW1lcgpbICAgIDAuMTgyOTg3XSBORVQ6
IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDIKWyAgICAwLjE4ODMwN10gVENQIGVzdGFibGlz
aGVkIGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDAsIDQwOTYgYnl0ZXMpClsgICAg
MC4xOTU4MjNdIFRDUCBiaW5kIGhhc2ggdGFibGUgZW50cmllczogMTAyNCAob3JkZXI6IDEsIDgx
OTIgYnl0ZXMpClsgICAgMC4yMDI2NzZdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0
YWJsaXNoZWQgMTAyNCBiaW5kIDEwMjQpClsgICAgMC4yMDk2MTNdIFVEUCBoYXNoIHRhYmxlIGVu
dHJpZXM6IDI1NiAob3JkZXI6IDEsIDgxOTIgYnl0ZXMpClsgICAgMC4yMTU4ODZdIFVEUC1MaXRl
IGhhc2ggdGFibGUgZW50cmllczogMjU2IChvcmRlcjogMSwgODE5MiBieXRlcykKWyAgICAwLjIy
Mjg5NF0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxClsgICAgMC4yMjkxOTldIHdv
cmtpbmdzZXQ6IHRpbWVzdGFtcF9iaXRzPTMwIG1heF9vcmRlcj0xNSBidWNrZXRfb3JkZXI9MApb
ICAgIDAuMjQxNjc1XSBzcXVhc2hmczogdmVyc2lvbiA0LjAgKDIwMDkvMDEvMzEpIFBoaWxsaXAg
TG91Z2hlcgpbICAgIDAuMjQ4MDIwXSBqZmZzMjogdmVyc2lvbiAyLjIuIChOQU5EKSAoU1VNTUFS
WSkgIO+/ve+/vSAyMDAxLTIwMDYgUmVkIEhhdCwgSW5jLgpbICAgIDAuMjU5MjIzXSBpbyBzY2hl
ZHVsZXIgbm9vcCByZWdpc3RlcmVkClsgICAgMC4yNjM0MThdIGlvIHNjaGVkdWxlciBkZWFkbGlu
ZSByZWdpc3RlcmVkIChkZWZhdWx0KQpbICAgIDAuMjY4OTc3XSBpbyBzY2hlZHVsZXIgbXEtZGVh
ZGxpbmUgcmVnaXN0ZXJlZApbICAgIDAuMjczODE3XSBpbyBzY2hlZHVsZXIga3liZXIgcmVnaXN0
ZXJlZApbICAgIDAuMjc5MjA2XSBTZXJpYWw6IDgyNTAvMTY1NTAgZHJpdmVyLCAyIHBvcnRzLCBJ
UlEgc2hhcmluZyBkaXNhYmxlZApbICAgIDAuMjg3MDQ1XSBjb25zb2xlIFt0dHlTMF0gZGlzYWJs
ZWQKWyAgICAwLjI5MDkzM10gMTgwMDAzMDAuc2VyaWFsOiB0dHlTMCBhdCBNTUlPIDB4MTgwMDAz
MDAgKGlycSA9IDE4LCBiYXNlX2JhdWQgPSA2MjUwMDAwKSBpcyBhIDE2NTUwClsgICAgMC4zMDA0
MjBdIGNvbnNvbGUgW3R0eVMwXSBlbmFibGVkClsgICAgMC4zMDA0MjBdIGNvbnNvbGUgW3R0eVMw
XSBlbmFibGVkClsgICAgMC4zMDc2MTRdIGJvb3Rjb25zb2xlIFtuczE2NTUwXSBkaXNhYmxlZApb
ICAgIDAuMzA3NjE0XSBib290Y29uc29sZSBbbnMxNjU1MF0gZGlzYWJsZWQKWyAgICAwLjMxOTMw
OF0gbGlicGh5OiBGaXhlZCBNRElPIEJ1czogcHJvYmVkCiguLi4pCg==
--00000000000059390a05688c593a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--00000000000059390a05688c593a--
