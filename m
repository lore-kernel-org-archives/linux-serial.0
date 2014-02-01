From: Beat Bolli <bbolli@ewanet.ch>
Subject: PROBLEM: BUG: scheduling while atomic in the 8250 serial driver
Date: Sat, 01 Feb 2014 13:48:13 +0100
Message-ID: <52ECED0D.4090202@ewanet.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="osHBEfTTIK1iimTCqBCPvIweHkxMs58vO"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.2b3w.ch ([92.42.186.250]:40383 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaBAMvQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 1 Feb 2014 07:51:16 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--osHBEfTTIK1iimTCqBCPvIweHkxMs58vO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

Firstly, I hope that my analysis of the stack trace is correct and this
is really a serial driver problem. Anyway, here goes:

I have a serial GPS with PPS on the RTS pin attached to my Atom N270
motherboard, using it, besides being my home server and Internet
gateway, as a Stratum 0 NTP server. Recently[1], the kernel started
producing BUGs as follows:

[10671.576706] BUG: scheduling while atomic: blosxom.cgi/8118/0x10010000
[10671.578300] Modules linked in: pps_ldisc binfmt_misc tun sit tunnel4
ip_tunnel ipt_MASQUERADE xt_nat iptable_nat nf_nat_ipv4 nf_nat
ipt_REJECT xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_multiport
xt_conntrack nf_conntrack iptable_filter ip_tables x_tables loop i915
iTCO_wdt iTCO_vendor_support coretemp acpi_cpufreq processor video
drm_kms_helper drm lpc_ich i2c_algo_bit mfd_core button i2c_i801
i2c_core snd_pcm snd_page_alloc snd_timer rng_core snd thermal_sys
soundcore pcspkr psmouse serio_raw evdev joydev ext4 crc16 mbcache jbd2
btrfs xor hid_microsoft raid6_pq crc32c libcrc32c hid_generic usbhid
usb_storage hid sg sd_mod crc_t10dif crct10dif_common ata_generic
ata_piix libata scsi_mod ehci_pci uhci_hcd ehci_hcd usbcore usb_common
e1000e ptp pps_core
[10671.578455] CPU: 0 PID: 8118 Comm: blosxom.cgi Tainted: G        W
 3.12-1-686-pae #1 Debian 3.12.6-2
[10671.578461] Hardware name: MSI A9830IMS/A9830IMS, BIOS 080015  12/15/2=
008
[10671.578468]  c0105514 c13fe5a9 10010000 c13fc1c8 c14c954c dd65746c
00001fb6 10010000
[10671.578486]  00000000 c140113c 00000046 c1626400 c1626400 df7a5400
c1626400 00000000
[10671.578502]  00000000 c1626400 00000000 00000000 dd5744c0 c1076170
00000000 00000000
[10671.578517] Call Trace:
[10671.578538]  [<c13fe5a9>] ? dump_stack+0x3e/0x4e
[10671.578549]  [<c13fc1c8>] ? __schedule_bug+0x4d/0x5e
[10671.578561]  [<c140113c>] ? __schedule+0x6fc/0x710
[10671.578573]  [<c1076170>] ? wake_up_state+0x10/0x10
[10671.578584]  [<c114fba0>] ? poll_select_copy_remaining+0x110/0x110
[10671.578595]  [<c1070676>] ? __wake_up_common+0x46/0x70
[10671.578606]  [<c1074593>] ? __cond_resched+0x13/0x30
[10671.578615]  [<c140145d>] ? _cond_resched+0x1d/0x30
[10671.578624]  [<c1400758>] ? down_read+0x8/0x20
[10671.578636]  [<c12b59dc>] ? n_tty_receive_buf2+0x2c/0xb0
[10671.578656]  [<c12b59b0>] ? __receive_buf+0x7b0/0x7b0
[10671.578666]  [<c12b89ba>] ? flush_to_ldisc+0xba/0x110
[10671.578678]  [<c12cea51>] ? serial8250_rx_chars+0xa1/0x1b0
[10671.578688]  [<c12cebb5>] ? serial8250_handle_irq.part.13+0x55/0x90
[10671.578698]  [<c12cdf04>] ? serial8250_interrupt+0x44/0xb0
[10671.578710]  [<c109124c>] ? handle_irq_event_percpu+0x2c/0x1a0
[10671.578721]  [<c10913e2>] ? handle_irq_event+0x22/0x40
[10671.578731]  [<c109342e>] ? handle_edge_irq+0x5e/0xf0
[10671.578743]  [<c1010a10>] ? handle_irq+0x30/0x80
[10671.578752]  [<c10103f1>] ? do_IRQ+0x31/0xa0
[10671.578764]  [<c1409bb3>] ? common_interrupt+0x33/0x38
[10671.578774]  [<c140007b>] ? __ww_mutex_lock_slowpath+0x9e/0x203
[10976.065431] pps pps0: removed

This is a stock Debian kernel, current as of today in Debian testing.

The last line of the syslog shows me stopping gpsd and detaching the GPS
receiver from the serial port. After this, no more BUGs were reported.

This may be relevant output from /var/log/dmesg:

$ egrep 'IRQ|ttyS' /var/log/dmesg
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] NR_IRQS:2304 nr_irqs:512 16
[    0.130450] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12
14 15)
[    0.130617] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12
14 15)
[    0.130778] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12
14 15)
[    0.130939] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12
14 15)
[    0.131101] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12
14 15) *0, disabled.
[    0.131263] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12
14 15) *0, disabled.
[    0.131425] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12
14 15) *0, disabled.
[    0.131589] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12
14 *15)
[    0.132214] PCI: Using ACPI for IRQ routing
[    0.132815] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.228686] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.249289] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
)
is a 16550A
[    1.269991] 00:0a: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200=
)
is a 16550A


Thanks,
Beat Bolli


[1] Re "recently": I may well be mistaken, but I think that this started
after the upgrade to the first 3.12 kernel.

--=20
mail: echo '<bNbolOli@ewaSPnetAM.ch>' | tr -d '[A-S]'
pgp: 0x506A903A; 49D5 794A EA77 F907 764F  D89E 304B 93CF 506A 903A
gsm: 4.7.7.6.0.7.7.9.7.1.4.e164.arpa
icbm: 47.0452 N, 7.2715 E

"It takes love over gold, and mind over matter" -- Dire Straits


--osHBEfTTIK1iimTCqBCPvIweHkxMs58vO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLs7REACgkQMEuTz1BqkDphSwCfdq467adr8XC1+cTD0xD45oF6
yHkAnR8H/QnBU2PM1F/ddLMzB4OW4qix
=Fhpr
-----END PGP SIGNATURE-----

--osHBEfTTIK1iimTCqBCPvIweHkxMs58vO--
