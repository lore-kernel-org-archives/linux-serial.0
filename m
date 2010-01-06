From: =?ISO-8859-1?Q?Szigetv=E1ri_J=E1nos?= <jszigetvari@gmail.com>
Subject: making an ibm bluetooth pc card work under linux
Date: Wed, 6 Jan 2010 19:57:56 +0100
Message-ID: <c66253311001061057t70ebca7dka55bc3de2fe62521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55466 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416Ab0AFS57 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jan 2010 13:57:59 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-pcmcia@lists.infradead.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org

Hi all!

I really don't mean to spam the lists, but I have run into a problem,
that is related to the subsystems covered by these list.
The guys at the linux-pcmcia list have already helped me a lot.

So the basic facts are:
I'm using Slackware Linux 13.0 with kernel 2.6.30.9 on an old laptop.
I have an older IBM Bluetooth PC Card, that seems to be currently
unsupported by Linux.
This card is a rebranded version of a similar TDK Bluetooth PC Card.

# pccardctl info
PRODID_1="IBM"
PRODID_2="Bluetooth PC Card II"
PRODID_3=""
PRODID_4=""
MANFID=0105,4254
FUNCID=254

There was a discussion about this card on the linux.pcmcia.devel
newsgroup/mailing-list a while ago:
http://osdir.com/ml/linux.pcmcia.devel/2003-04/msg00001.html
There it was identified that this card is Oxford Semiconductor 16C950-based.

There also was a problem with the card, as it had a Card Information
Structure, that contained incorrect information. Luckily I was able to
correct the CIS, so now it looks like this:

dev_info
 NULL 0ns, 512b
manfid 0x0105, 0x4254
funcid serial_port [post]
vers_1 7.1, "IBM", "Bluetooth PC Card II", "", ""
config base 0x00f8 mask 0x000f last_index 0x03
cftable_entry 0x03 [default]
 [rdybsy]
 Vcc Vnom 5V
 io 0x01e0-0x01ef [lines=8] [8bit] [range]
 irq mask 0xffff [level] [shared]

Using the info found in the list archive, and some help from Dominik
Brodowski on the linux-pcmcia list, I was able to make a patch that
(in most cases) is able to make this card work:

diff -uNr a/drivers/serial/serial_cs.c b/drivers/serial/serial_cs.c
--- a/drivers/serial/serial_cs.c	2009-10-05 17:38:08.000000000 +0200
+++ b/drivers/serial/serial_cs.c	2010-01-05 20:38:48.000000000 +0100
@@ -212,6 +212,11 @@
 		.multi	= -1,
 		.post	= quirk_post_ibm,
 	}, {
+		.manfid	= MANFID_TDK,
+		.prodid	= PRODID_TDK_BTPC01,
+		.multi	= -1,
+		.wakeup	= quirk_wakeup_oxsemi,
+	}, {
 		.manfid	= MANFID_INTEL,
 		.prodid	= PRODID_INTEL_DUAL_RS232,
 		.multi	= 2,
@@ -658,6 +663,19 @@
 		return 0;
 	}

+	if (info->manfid == MANFID_TDK && info->prodid == PRODID_TDK_BTPC01) {
+		/* The CIS for this card only has one config entry. */
+		setup_serial(link, info, link->io.BasePort1,
+					link->irq.AssignedIRQ);
+		info->c950ctrl = base2;
+
+		if (info->quirk && info->quirk->wakeup) {
+			info->quirk->wakeup(link);
+		}
+
+		return 0;
+	}
+
 	setup_serial(link, info, link->io.BasePort1, link->irq.AssignedIRQ);
 	for (i = 0; i < info->multi - 1; i++)
 		setup_serial(link, info, base2 + (8 * i),
@@ -871,6 +889,7 @@
 	PCMCIA_DEVICE_CIS_MANF_CARD(0x0192, 0x0710, "SW_7xx_SER.cis"),	/*
Sierra Wireless AC710/AC750 GPRS Network Adapter R1 */
 	PCMCIA_DEVICE_CIS_MANF_CARD(0x0192, 0xa555, "SW_555_SER.cis"),  /*
Sierra Aircard 555 CDMA 1xrtt Modem -- pre update */
 	PCMCIA_DEVICE_CIS_MANF_CARD(0x013f, 0xa555, "SW_555_SER.cis"),  /*
Sierra Aircard 555 CDMA 1xrtt Modem -- post update */
+	PCMCIA_DEVICE_CIS_MANF_CARD(0x0105, 0x4254, "cis/IBMBT.cis"),	/* IBM
Bluetooth PC Card II */
 	PCMCIA_DEVICE_CIS_PROD_ID12("MultiTech", "PCMCIA 56K DataFax",
0x842047ee, 0xc2efcf03, "MT5634ZLX.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-4",
0x96913a85, 0xcec8f102, "COMpad4.cis"),
 	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0",
0x96913a85, 0x8fbe92ae, 0x0877b627, "COMpad2.cis"),
diff -uNr a/include/pcmcia/ciscode.h b/include/pcmcia/ciscode.h
--- a/include/pcmcia/ciscode.h	2009-10-05 17:38:08.000000000 +0200
+++ b/include/pcmcia/ciscode.h	2010-01-03 23:07:10.000000000 +0100
@@ -116,6 +116,7 @@
 #define PRODID_TDK_NP9610		0x0d0a
 #define PRODID_TDK_MN3200		0x0e0a
 #define PRODID_TDK_GN3410		0x4815
+#define PRODID_TDK_BTPC01		0x4254

 #define MANFID_TOSHIBA			0x0098

This is where I'm now.
After compiling and installing the modified module, the card sometimes
works, and sometimes it doesn't.

If everything is OK, and the HCI is registered, I get the following messages:

root@orion:~# tail /var/log/messages
Jan  5 10:39:09 orion kernel: pcmcia 1.0: firmware: requesting cis/IBMBT.cis
Jan  5 10:39:09 orion kernel: 1.0: ttyS1 at I/O 0x1e0 (irq = 3) is a 16C950/954
Jan  5 10:39:10 orion kernel: Bluetooth: HCI UART driver ver 2.2
Jan  5 10:39:10 orion kernel: Bluetooth: HCI H4 protocol initialized
Jan  5 10:39:10 orion kernel: Bluetooth: HCI BCSP protocol initialized
Jan  5 10:39:10 orion kernel: Bluetooth: HCILL protocol initialized
Jan  5 10:39:10 orion hcid[2462]: HCI dev 0 registered
Jan  5 10:39:10 orion hcid[2462]: HCI dev 0 up
Jan  5 10:39:10 orion hcid[2462]: Device hci0 has been added
Jan  5 10:39:10 orion hcid[2462]: Starting security manager 0
root@orion:~# tail /var/log/syslog
Jan  5 10:39:09 orion kernel: ttyS1: detected caps 00000700 should be 00000100
Jan  5 10:39:11 orion hcid[2462]: Can't read version info for hci0:
Connection timed out (110)
Jan  5 10:39:20 orion hcid[2605]: Can't set link policy on hci0:
Connection timed out (110)
Jan  5 10:39:20 orion kernel: hci_cmd_task: hci0 command tx timeout

If the registration of the HCI fails, I get this:

root@orion:~# dmesg | tail
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
pcmcia_socket pcmcia_socket1: pccard: PCMCIA card inserted into slot 1
pcmcia_socket pcmcia_socket1: cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia 1.0: pcmcia: registering new device pcmcia1.0
pcmcia 1.0: firmware: requesting cis/IBMBT.cis
ttyS1: detected caps 00000700 should be 00000100
1.0: ttyS1 at I/O 0x1e0 (irq = 3) is a 16C950/954
root@orion:~# tail /var/log/syslog
Oct 25 00:40:07 orion hcid[2465]: Can't create GN bridge
Jan  4 23:29:07 orion kernel: ttyS1: detected caps 00000700 should be 00000100
root@orion:~# tail /var/log/messages
Jan  4 23:29:07 orion kernel: pcmcia_socket pcmcia_socket1: pccard:
PCMCIA card inserted into slot 1
Jan  4 23:29:07 orion kernel: pcmcia_socket pcmcia_socket1: cs: memory
probe 0xa0000000-0xa0ffffff: clean.
Jan  4 23:29:07 orion kernel: pcmcia 1.0: pcmcia: registering new
device pcmcia1.0
Jan  4 23:29:07 orion kernel: pcmcia 1.0: firmware: requesting cis/IBMBT.cis
Jan  4 23:29:07 orion kernel: 1.0: ttyS1 at I/O 0x1e0 (irq = 3) is a 16C950/954
Jan  4 23:29:17 orion hciattach: BCSP initialization timed out

Another thing is that if I go through a suspend/resume cycle, then the
HCI doesn't work afterwards, even though the HCI was  successfully
registered before the suspension of the system. Of course this may
also be a bug/deficiency of the pm-utils package, that Slackware makes
use of.
Anyway, the symptom of this is that any commands that I pass to the
HCI reach a time out. (hciconfig hci0 reset for example.)

As the HCI interface now works sometimes I was able to query the following info:

oot@orion:~/dev/kernel# hciconfig hci0 features
hci0:   Type: UART
       BD Address: 00:80:98:34:55:46 ACL MTU: 192:8 SCO MTU: 64:8
       Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
               <3-slot packets> <5-slot packets> <encryption> <slot offset>
               <timing accuracy> <role switch> <hold mode> <sniff mode>
               <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
               <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
               <transparent SCO>
root@orion:~/dev/kernel# hciconfig hci0 commands
Can't read support commands on hci0: Connection timed out (110)
root@orion:~/dev/kernel# hciconfig hci0 revision
hci0:   Type: UART
       BD Address: 00:80:98:34:55:46 ACL MTU: 192:8 SCO MTU: 64:8
       HCI 12.3
       Chip version: BlueCore01b
       SCO mapping:  HCI
root@orion:~/dev/kernel# hciconfig hci0 version
hci0:   Type: UART
       BD Address: 00:80:98:34:55:46 ACL MTU: 192:8 SCO MTU: 64:8
       HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver: 0x86
       Manufacturer: Cambridge Silicon Radio (10)


I have run out of ideas where to look for the error that could cause
these symptoms. So if you have any helping idea or input, please don't
hesitate to to hit the reply button.
Thanks!

Best regards,
Janos Szigetvari
