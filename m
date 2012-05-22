From: Jack Stone <jwjstone@fastmail.fm>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Tue, 22 May 2012 15:44:15 +0100
Message-ID: <4FBBA63F.2050501@fastmail.fm>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com> <4FBB8742.7050504@fastmail.fm> <20120522151033.33ef577a@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:32985 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754139Ab2EVOoS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 May 2012 10:44:18 -0400
In-Reply-To: <20120522151033.33ef577a@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, deathonfuneral@gmail.com

[Re-adding original poster an LKML after I accidentally dropped them.
 Sorry about that]

On 05/22/2012 03:10 PM, Alan Cox wrote:
>> I'm newbie, working under existed serial driver, adapting it for 2.6.32.
>> During the compilation I have had several problems, which I
>> succesfully solved except this one:
>> error: 'struct tty_struct' has no member named 'flip'
>> In particular, cound you advice correct replacement of "tty->flip.count"
> 
> Your driver shouldn't be looking in those areas. There isn't a correct
> replacement. You will need to update it to use the flip buffers properly
> not poke its nose in places it shouldn't have.
> 
> Perhaps the best thing would be to post a link to the driver ?
> 
> Alan

