From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH] input: ct82710c: return proper error code for
 ct82c710_open
Date: Mon, 17 Jan 2011 09:43:25 -0300
Message-ID: <1295268205.2130.0.camel@offworld>
References: <1294940150.2200.4.camel@offworld>
	 <20110117082251.GB22802@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:46452 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab1AQOxq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jan 2011 09:53:46 -0500
In-Reply-To: <20110117082251.GB22802@core.coreip.homeip.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Mon, 2011-01-17 at 00:22 -0800, Dmitry Torokhov wrote:
> On Thu, Jan 13, 2011 at 02:35:50PM -0300, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > If request_irq() fails we should return the proper error instead of -1.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> 
> Will apply, thank you. You don't really have the device, do you?
> 
No, I don't have that device, but looks trivial enough to be
compile-tested only.

Thanks.

> Thanks.
> 


