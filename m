From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] pch_uart: Fix parity setting issue
Date: Fri, 6 Jul 2012 11:22:36 +0100
Message-ID: <20120706112236.5245ac66@pyramind.ukuu.org.uk>
References: <1341562783-5571-1-git-send-email-tomoya.rohm@gmail.com>
	<1341562783-5571-2-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52348 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab2GFKTG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jul 2012 06:19:06 -0400
In-Reply-To: <1341562783-5571-2-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri,  6 Jul 2012 17:19:43 +0900
Tomoya MORINAGA <tomoya.rohm@gmail.com> wrote:

> Parity Setting value is reverse.
> E.G. In case of setting ODD parity, EVEN value is set.
> This patch inverts "if" condition.
> 
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>

Acked-by: Alan Cox <alan@linux.intel.com>
