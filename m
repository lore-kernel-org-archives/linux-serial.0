From: Jack Stone <jwjstone@fastmail.fm>
Subject: Fwd: struct tty_flip_buffer replacement in newer kernels
Date: Tue, 22 May 2012 13:32:02 +0100
Message-ID: <4FBB8742.7050504@fastmail.fm>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35558 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753360Ab2EVMkc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 May 2012 08:40:32 -0400
In-Reply-To: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org

[Add CCs]

-------- Original Message --------
Subject: struct tty_flip_buffer replacement in newer kernels
Date: Tue, 22 May 2012 16:17:02 +0400
From: Dmitriy Alekseev <deathonfuneral@gmail.com>
To: linux-kernel@vger.kernel.org

Hello

I'm newbie, working under existed serial driver, adapting it for 2.6.32.
During the compilation I have had several problems, which I
succesfully solved except this one:
error: 'struct tty_struct' has no member named 'flip'
In particular, cound you advice correct replacement of "tty->flip.count"

Thanks
-- 
Best Regards,
Dmitriy Alekseev
