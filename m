From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial_core's port->count mess
Date: Thu, 19 May 2011 11:25:44 +0100
Message-ID: <20110519112544.41979e53@lxorguk.ukuu.org.uk>
References: <BANLkTim=dgCwFTeCyz273nBq4MGQs1FJsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43871 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752177Ab1ESKYL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 May 2011 06:24:11 -0400
In-Reply-To: <BANLkTim=dgCwFTeCyz273nBq4MGQs1FJsw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-serial@vger.kernel.org

> So, the problem seems to be that the port->count in the serial_core
> isn't 1 & hence the call,

So you've got it open in two places

> What is the this count used for?

Number of live openers basically

> Also how is this related to chip not responding to certain commands?

No idea
