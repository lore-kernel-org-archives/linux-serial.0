From: narasimharo bolisetti <nrbolisetti@yahoo.com>
Subject: system hang
Date: Thu, 10 Apr 2014 00:05:52 -0700 (PDT)
Message-ID: <1397113552.75117.YahooMailBasic@web160504.mail.bf1.yahoo.com>
References: <62C418AB752FEF4D931AB8E89E46539F02878DFC@chn-hclt-mbs06.HCLT.CORP.HCL.IN>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <62C418AB752FEF4D931AB8E89E46539F02878DFC@chn-hclt-mbs06.HCLT.CORP.HCL.IN>
Sender: linux-pci-owner@vger.kernel.org
To: "kernelnewbies@nl.linux.org" <kernelnewbies@nl.linux.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, Narasimharao Bolisetti <narasimharao.b@hcl.com>
Cc: "nrbolisetti@gmail.com" <nrbolisetti@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

 Hi Greg/All,=20
  =C2=A0=20
 This is Narasimharao working for a s/wcompany HCLT..=20
  =C2=A0=20
 I am working a issue and
 the description is below:=20
  =C2=A0=20
 system stops booting and
 needs a series of console inputs (space bar or return) to
 continue booting. Each input advances the process a little
 bit.=20
 Actually I am trying to
 upgrade the s/w from usb pendrive, part of this upgrade
 having multiple times we are disconnecting and connecting
 the usb pen drive.=20
  =C2=A0=20
 system stops booting and
 needs a series of console inputs (space bar or return) to
 continue booting. Each input advances the process a little
 bit.=20
 I have tried to find the
 root cause for the issue but not get success, can you help
 me regarding to this what is the root cause and how i can
 fix this?=20
  =C2=A0=20
 One more thing i observed
 that the space allocated for tty by 'tty_write_room'
 is suddenly consumed by more than 2k at the time of issue
 occurs and gradually
 =20
 consuming remaining memory
 and when reaches to zero upgrade completely hangs and when
 console inputs (space bar or return) to continue booting,
 =20
 Each input advances the
 process a little bit. This console i/p's creating some
 space for the same . Is this problem in tty?
 =20
 one more thing we observed
 that whenever we increase the logging then this problem
 happens regularly.=20
  =C2=A0=20
 [=C2=A0=C2=A0 66.233676]
 EXT3-fs (sda14): using internal journal=20
 [=C2=A0=C2=A0 66.233691]
 EXT3-fs (sda14): mounted filesystem with ordered data
 mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
 =20
 [=C2=A0=C2=A0 76.822878]
 par.que...par_queue_user_receive: Freeze check =3D0=20
 [=C2=A0=C2=A0 76.828711]
 par.que...par_queue_user_receive: <*> returned
 -ERESTARTSYS <*> event =3D-512=20
 [=C2=A0=C2=A0 76.837241]
 par_ldisc_open:record is found for ttyS4=20
 [=C2=A0=C2=A0 76.842766]
 par.que...par_queue_user_receive: Freeze check =3D0=20
 [=C2=A0=C2=A0 76.848594]
 par.que...par_queue_user_receive: <*> returned
 -ERESTARTSYS <*> event =3D-512=20
 [=C2=A0 101.781654] usb
 1-1.3: USB disconnect, address 3=20
 [=C2=A0 104.029178] usb
 1-1.3: new high speed USB device using fsl-ehci and address
 4=20
 [=C2=A0 104.159085] scsi2
 : usb-storage 1-1.3:1.0=20
 [=C2=A0 105.163726] scsi
 2:0:0:0: Direct-Access=C2=A0=C2=A0=C2=A0=C2=A0 Kingston
 DataTraveler 2.0 1.00 PQ: 0 ANSI: 2=20
 [=C2=A0 105.173202] sd
 2:0:0:0: Attached scsi generic sg1 type 0=20
 [=C2=A0 105.173686] sd
 2:0:0:0: [sdb] 4006912 512-byte logical blocks: (2.05
 GB/1.91 GiB)=20
 [=C2=A0 105.174177] sd
 2:0:0:0: [sdb] Write Protect is off=20
 [=C2=A0 105.174188] sd
 2:0:0:0: [sdb] Mode Sense: 23 00 00 00=20
 [=C2=A0 105.174197] sd
 2:0:0:0: [sdb] Assuming drive cache: write through=20
 [=C2=A0 105.178804] sd
 2:0:0:0: [sdb] Assuming drive cache: write through=20
 [=C2=A0 105.178825]=C2=A0
 sdb: sdb1=20
 [=C2=A0 105.295052] sd
 2:0:0:0: [sdb] Assuming drive cache: write through=20
 [=C2=A0 105.301142] sd
 2:0:0:0: [sdb] Attached SCSI removable
 disk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
 - Hangs at this place and
 console i/p=E2=80=99s to continue booting.=20
  =C2=A0=20
 I have tried with
 different sizes and different vendors pen drives but problem
 is the same and occurs at the same place.=20
  =C2=A0=20
 Your valuable inputs and
 suggetions are helpful to fix this issue.=20
  =C2=A0=20
 My kernel version is:
 2.6.35.6-45.fc14.i686=20
  =C2=A0=20
 Thanks in advance for
 helping and replying.=20
  =C2=A0=20
  =C2=A0=20
 Regards,=20
 Narasimharao B=20
  =C2=A0=20
  =C2=A0=20
  =C2=A0=20
  =C2=A0=20
  =C2=A0=20
=20
=20
=20
=20
 ::DISCLAIMER::
 ----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-------
 The contents of
 this e-mail and any attachment(s) are confidential and
 intended for the named recipient(s) only.
 E-mail transmission is not guaranteed to be secure or
 error-free as information could be intercepted, corrupted,=20
 lost, destroyed, arrive late or incomplete, or may contain
 viruses in transmission. The e mail and its contents=20
 (with or without referred errors) shall therefore not attach
 any liability on the originator or HCL or its affiliates.=20
 Views or opinions, if any, presented in this email are
 solely those of the author and may not necessarily reflect
 the=20
 views or opinions of HCL or its affiliates. Any form of
 reproduction, dissemination, copying, disclosure,
 modification,=20
 distribution and / or publication of this message without
 the prior written consent of authorized representative of=20
 HCL is strictly prohibited. If you have received this email
 in error please delete it and notify the sender immediately.
=20
 Before opening any email and/or attachments, please check
 them for viruses and other defects.
 ----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-------
=20
=20
