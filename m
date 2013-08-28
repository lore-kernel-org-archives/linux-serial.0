From: Kumar Gala <galak@codeaurora.org>
Subject: Re: merging device tree binding dirs for serial bindings
Date: Wed, 28 Aug 2013 13:49:13 -0500
Message-ID: <0F60E12D-C0BF-4185-85FF-0BC879B3C1F0@codeaurora.org>
References: <F93329E6-1426-4197-871D-211F34455DDE@codeaurora.org> <20130828183534.GC14627@kroah.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:47367 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab3H1StL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Aug 2013 14:49:11 -0400
In-Reply-To: <20130828183534.GC14627@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org Guo" <shawn.guo@linaro.org>, "s.hauer@pengutronix.de Hauer" <s.hauer@pengutronix.de>


On Aug 28, 2013, at 1:35 PM, Greg Kroah-Hartman wrote:

> On Wed, Aug 28, 2013 at 01:02:14PM -0500, Kumar Gala wrote:
>> We appear to have:
>> 
>> Documentation/devicetree/bindings/serial/
>> 
>> and
>> 
>> Documentation/devicetree/bindings/tty/serial/
>> 
>> Which one do we want to keep, I'd pick the first, but I don't care too much.
> 
> I don't care, I never created either one, and don't do any devicetree
> stuff, so it's up to the devicetree maintainers to pick one.
> 
> thanks,
> 
> greg k-h

Since you don't care we'll go with bindings/serial.

I'll send a patch to merge and clean this up.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

