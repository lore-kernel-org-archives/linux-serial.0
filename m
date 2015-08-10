From: Noam Camus <noamc@ezchip.com>
Subject: Re: [v2 3/3] serial: 8250_dw: Add UPF_SKIP_TEST to flags depend on
 device tree
Date: Mon, 10 Aug 2015 19:21:25 +0000
Message-ID: <DB4PR02MB2729A7E7AC1868DA4F8D79ED6700@DB4PR02MB272.eurprd02.prod.outlook.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-2-git-send-email-noamc@ezchip.com>
 <1437886478-29273-3-git-send-email-noamc@ezchip.com>
 <1437886478-29273-4-git-send-email-noamc@ezchip.com>,<20150803234406.GC5257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803234406.GC5257@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Greg KH <greg@kroah.com>
Sent: Tuesday, August 4, 2015 2:44 AM

> > From: Noam Camus <noamc@ezchip.com>
> >
> > Add support for OF option "no-loopback-test"
> >
> > use case: simulator which does not implements loopback test mode.
>
> Can't you just fix the simulator to be "correct"?

I just got this simulator pre-built and as kernel developer I borrowed from generic 8250 this idea for OF option. seem to me that loopback test is optional since kernel for generic 8250 already support  "no-loopback-test" option.

Noam