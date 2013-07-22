From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] serial: arc_uart: Fix module alias
Date: Mon, 22 Jul 2013 16:40:38 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075139A0F@IN01WEMBXA.internal.synopsys.com>
References: <1374372855.5167.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:40998 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab3GVQkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Jul 2013 12:40:43 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 07/20/2013 07:14 PM, Axel Lin wrote:
> Platform drivers use "platform:" prefix in module alias.
> Also use DRIVER_NAME in MODULE_ALIAS to make module autoloading work.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx,
-Vineet
