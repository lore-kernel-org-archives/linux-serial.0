From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 1/7] serial: arc_uart: Remove casting the return value
 which is a void pointer
Date: Mon, 9 Sep 2013 06:05:19 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230751476FF@IN01WEMBXA.internal.synopsys.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:37064 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab3IIGFY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 02:05:24 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 09/09/2013 10:36 AM, Jingoo Han wrote:
> Casting the return value which is a void pointer is redundant.
> The conversion from void pointer to any other pointer type is
> guaranteed by the C programming language.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Thx for the cleanup.
-Vineet
