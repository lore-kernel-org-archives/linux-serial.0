From: "Milan P. Stanic" <mps@rns-nis.co.yu>
Subject: Re: Help in setting up serial console on 64 bit machine
Date: Tue, 9 Mar 2004 10:41:33 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040309094133.GB1826@rns-nis.co.yu>
References: <53CF1076699CD711B7DD0002A51363F102C3602D@exw-ks.ks.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sq.rns-nis.co.yu ([194.247.213.11]:45770 "EHLO sq.rns-nis.co.yu")
	by vger.kernel.org with ESMTP id S261252AbUCIJtO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Mar 2004 04:49:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by sq-int.rns-nis.co.yu (Postfix) with SMTP id 8AAEF6B959
	for <linux-serial@vger.kernel.org>; Tue,  9 Mar 2004 10:49:36 +0100 (CET)
Received: from dl.oss.co.yu (mps.rns-nis.co.yu [194.247.213.6])
	by sq.rns-nis.co.yu (Postfix) with ESMTP id 16BFB6BAAD
	for <linux-serial@vger.kernel.org>; Tue,  9 Mar 2004 10:49:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <53CF1076699CD711B7DD0002A51363F102C3602D@exw-ks.ks.lsil.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Mon, Mar 08, 2004 at 09:10:47AM -0600, Dachepalli, Sudhir wrote:
> After selecting "label=serial" and botting the OS the following is the
> command line from proc.
> [root@beast root]# cat /proc/cmdline
> BOOT_IMAGE=scsi0:EFI\redhat\vmlinuz-2.4.18-e.37smp  root=LABEL=/
> console=ttyS1,9600n8 console=tty0 ro

The kernel message is directed to the last console specified in
the lilo or grub. I don't know for elilo but because this is actually
kernel command line parameter it should be same.

Try to swap consoles in (e)lilo.

hth
