From: Subodh Nijsure <nijsure.subodh@gmail.com>
Subject: Help with Implementing a custom line discipline driver
Date: Fri, 2 Dec 2011 05:45:59 -0800
Message-ID: <CAMFeL9Jjr_4L8a_8-QD=PZ6dGZF2LkxPHa2Ooc+poWfgDvkMow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60244 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab1LBNqA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Dec 2011 08:46:00 -0500
Received: by iage36 with SMTP id e36so4209793iag.19
        for <linux-serial@vger.kernel.org>; Fri, 02 Dec 2011 05:45:59 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

I am dealing with serial port hardware setup that requires me to
fiddle with some of the GPIO setup. So what I want to do is create a
new line discipline driver that provides implementation of few ioctl
interfaces. I don't really need to cook, buffer any of the rx/tx data.

So I tried to implement a line discipline that just implements open,
close, ioctl but when I do the following,

int ldisc = N_TESTLDISC;
fd = open(argv[1], O_RDWR | O_NOCTTY);
ioctl(fd,TIOCSETD,&disc);

and then invoke my custom ioctls, they do get invoked fine, however
actual data rx/tx does not happen.

So the question is, Is it possible  to implement line discipline
driver for serial port, that just provides ioctl?

If not what are the must have function that line discipline driver
must implement from struct tty_ldisc?

My tty_ldisc is shown below.

static struct tty_ldisc_ops tty_testldisc_ldisc = {
        .owner          = THIS_MODULE,
        .magic          = TTY_LDISC_MAGIC,
        .name           = DRIVERNAME,
        .open           = n_testldisc_open,
        .close          = n_testldisc_close,
        .ioctl          = n_testldisc_ioctl,
};

Regards,
-Subodh Nijsure
