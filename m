From: =?iso-8859-1?Q?Mats_K=E4rrman?= <Mats.Karrman@tritech.se>
Subject: RE: Suspecting kernel timing bug in ppp or tty drivers
Date: Wed, 12 Mar 2014 07:54:03 +0000
Message-ID: <ED3E0BCACD909541BA94A34C4A164D4C5B181221@post.tritech.se>
References: <ED3E0BCACD909541BA94A34C4A164D4C5B180258@post.tritech.se>
 <20140310194007.GC3392@kroah.com>
 <ED3E0BCACD909541BA94A34C4A164D4C5B180A77@post.tritech.se>,<20140311185019.GA32618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tritech.se ([46.59.120.190]:63058 "EHLO tritech.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283AbaCLHyN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Mar 2014 03:54:13 -0400
In-Reply-To: <20140311185019.GA32618@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-ppp@vger.kernel.org" <linux-ppp@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tuesday, March 11, 2014 7:50 PM, Greg KH wrote:
> On Tue, Mar 11, 2014 at 09:41:56AM +0000, Mats K=E4rrman wrote:
>> As the MPC5125 is not main-line and I have some drivers for propriet=
ary
>> hardware the porting and re-testing will take me at least a week I g=
uess.
>
> Why aren't these drivers and arch code upstream?

Well, the proprietary drivers are for hardware that only exist on our p=
roprietary
board so I guess community interest is limited. Of course the buyers of
the product will get access to the source if they want to.

The MPC5125 adaptions partly comes from the Freescale Linux demo for
the TWR5125 board so they are not mine to contribute. However I was
surprised to see that someone has started contributing 5125 stuff since
v3.2 so maybe there will be an opportunity for me to contribute as well=
,
once I get the new kernel running.

:) // Mats--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
