From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ct82710c: return proper error code for
 ct82c710_open
Date: Mon, 17 Jan 2011 00:22:51 -0800
Message-ID: <20110117082251.GB22802@core.coreip.homeip.net>
References: <1294940150.2200.4.camel@offworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54145 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab1AQIaX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jan 2011 03:30:23 -0500
Content-Disposition: inline
In-Reply-To: <1294940150.2200.4.camel@offworld>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Davidlohr Bueso <dave@gnu.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, Jan 13, 2011 at 02:35:50PM -0300, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> 
> If request_irq() fails we should return the proper error instead of -1.
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Will apply, thank you. You don't really have the device, do you?

Thanks.

-- 
Dmitry
