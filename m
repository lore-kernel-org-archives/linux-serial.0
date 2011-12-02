From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Help with Implementing a custom line discipline driver
Date: Fri, 2 Dec 2011 14:06:32 +0000
Message-ID: <20111202140632.4380c70c@lxorguk.ukuu.org.uk>
References: <CAMFeL9Jjr_4L8a_8-QD=PZ6dGZF2LkxPHa2Ooc+poWfgDvkMow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39441 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756602Ab1LBOEt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Dec 2011 09:04:49 -0500
In-Reply-To: <CAMFeL9Jjr_4L8a_8-QD=PZ6dGZF2LkxPHa2Ooc+poWfgDvkMow@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Subodh Nijsure <nijsure.subodh@gmail.com>
Cc: linux-serial@vger.kernel.org

> So the question is, Is it possible  to implement line discipline
> driver for serial port, that just provides ioctl?

No. A line discipline implements data processing for the tty and non
device specific interfaces.

Device specific extensions and interfaces should go into the tty driver
for that actual hardware. Unknown tty ioctls are also passed to the tty
drivers ioctl method to allow this.

Alan
