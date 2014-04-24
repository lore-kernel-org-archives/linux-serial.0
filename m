From: =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
Subject: Failed to suspend in 3.14.1
Date: Thu, 24 Apr 2014 11:04:33 +0200
Message-ID: <20140424090433.GT2554@vicerveza.homeunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40590 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbaDXJEk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Apr 2014 05:04:40 -0400
Received: from [77.231.177.17] (helo=mail.viric.name)
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <viric@viric.name>)
	id 1WdFa9-000CwJ-HO
	for linux-serial@vger.kernel.org; Thu, 24 Apr 2014 09:04:37 +0000
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

here my PC failed to suspend due to the serial port. Disabling the seri=
al
port in the BIOS allows the system to suspend and resume properly.

When the serial port is enabled, I get traces like those posted by diff=
erent
people:
https://bbs.archlinux.org/viewtopic.php?pid=3D1403725

https://bbs.archlinux.org/viewtopic.php?id=3D180525

Basically:
[ 3228.926444] PM: Syncing filesystems ... done.
[ 3228.975076] PM: Preparing system for mem sleep
[ 3229.654850] Freezing user space processes ... (elapsed 0.002 seconds=
) done.
[ 3229.657505] Freezing remaining freezable tasks ... (elapsed 5.171 se=
conds)
done.
[ 3234.832849] PM: Entering mem sleep
[ 3234.832913] Suspending console(s) (use no_console_suspend to debug)
[ 3234.833762] sd 4:0:0:0: [sdc] Synchronizing SCSI cache
[ 3234.833841] serial 00:09: disable failed
[ 3234.833853] dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns -5
[ 3234.833857] PM: Device 00:09 failed to suspend: error -5
[ 3234.833865] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
[ 3234.834061] sd 3:0:0:0: [sdb] Stopping disk
[ 3234.834986] sd 4:0:0:0: [sdc] Stopping disk
[ 3235.417070] PM: Some devices failed to suspend, or early wake event =
detected
[ 3235.417673] sd 3:0:0:0: [sdb] Starting disk
[ 3235.417694] sd 4:0:0:0: [sdc] Starting disk

I couldn't find any reference to a notice to kernel developers, so mayb=
e this
letter helps.

Thank you,
Llu=EDs.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
