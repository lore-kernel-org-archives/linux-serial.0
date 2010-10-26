From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [SERIAL]blacklist si3052 chip
Date: Tue, 26 Oct 2010 22:49:40 +0100
Message-ID: <20101026224940.22b4ac93@lxorguk.ukuu.org.uk>
References: <4CC73085.2070304@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38095 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753080Ab0JZVul (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Oct 2010 17:50:41 -0400
In-Reply-To: <4CC73085.2070304@o2.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Maciej Szmigiero <mhej@o2.pl>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 26 Oct 2010 21:48:21 +0200
Maciej Szmigiero <mhej@o2.pl> wrote:

> [SERIAL]blacklist si3052 chip
> 
> Si3052-based softmodems aren't serial ports so don't bind serial driver to them.
> Allows proper driver to bind to them.

Which is the proper driver ?

Alan
