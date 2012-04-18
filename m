From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: 8250: Add cpufreq support
Date: Wed, 18 Apr 2012 20:47:01 +0100
Message-ID: <20120418204701.31238fe7@pyramind.ukuu.org.uk>
References: <1333433022-5455-1-git-send-email-akshay.s@ti.com>
	<20120403105530.7fa3bce7@pyramind.ukuu.org.uk>
	<6F6B80BD2E18844D97BB4B51FE3705C831790EA0@DBDE01.ent.ti.com>
	<20120405115322.15e6088c@pyramind.ukuu.org.uk>
	<6F6B80BD2E18844D97BB4B51FE3705C83179146B@DBDE01.ent.ti.com>
	<20120412104758.3fc8085d@pyramind.ukuu.org.uk>
	<6F6B80BD2E18844D97BB4B51FE3705C83E92A183@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45222 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab2DRToj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 18 Apr 2012 15:44:39 -0400
In-Reply-To: <6F6B80BD2E18844D97BB4B51FE3705C83E92A183@DBDE01.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Shankarmurthy, Akshay" <akshay.s@ti.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "jamie@jamieiles.com" <jamie@jamieiles.com>, "swarren@nvidia.com" <swarren@nvidia.com>, "dianders@chromium.org" <dianders@chromium.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> As per my understanding, tty count keeps the count of tty_open and tty_release, that is
> how many open and close happened on the tty device file(/dev/ttyS*).
> The requirement here is a tty count check, if it is greater than zero then only it should
> proceed for further execution. 

The physical port has a different lifetime to the struct tty_struct
(which may change many times within the lifetime of the port). You can't
simply go from the port to a tty struct and assume this is safe and will
not change.

> Kindly elaborate more on the same if it's not correct.

Look at how tty_port_tty_get is used
