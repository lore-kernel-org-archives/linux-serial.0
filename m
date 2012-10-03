From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v3] serial/8250/8250_early: Prevent rounding error in
 uartclk
Date: Wed, 3 Oct 2012 16:53:06 +0400
Message-ID: <506C3532.4020400@synopsys.com>
References: <1349267263-21683-1-git-send-email-abrodkin@synopsys.com> <20121003133740.69c9dbce@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:43901 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab2JCMxU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Oct 2012 08:53:20 -0400
In-Reply-To: <20121003133740.69c9dbce@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Vineet.Gupta1@synopsys.com

On 03.10.2012 16:37, Alan Cox wrote:
>> So the bug had been latent and it only showed up with such low cock
>> rates.
>
> clock ?
>
> Perhaps Greg can tweak the description as it goes in - otherwise all
> fine with me
>
Sorry for this.
Essentially I meant "clock".
May do another respin if needed.
