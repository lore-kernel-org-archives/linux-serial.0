From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 7 Mar 2007 15:04:26 -0500
Message-ID: <8bd0f97a0703071204j3d60476boeccd2c1d573ddedf@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <m3bqj6jebt.fsf@maximus.localdomain>
	 <200703061824.08834.rgetz@blackfin.uclinux.org>
	 <57354eff0703070454u24e97309j55ec9de584ced71e@mail.gmail.com>
	 <m3649durx1.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:27872 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965560AbXCGUE1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2007 15:04:27 -0500
Received: by an-out-0708.google.com with SMTP id b33so250194ana
        for <linux-serial@vger.kernel.org>; Wed, 07 Mar 2007 12:04:26 -0800 (PST)
In-Reply-To: <m3649durx1.fsf@maximus.localdomain>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Oleksiy Kebkal <kebkal@gmail.com>, Robin Getz <rgetz@blackfin.uclinux.org>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On 3/7/07, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> "Oleksiy Kebkal" <kebkal@gmail.com> writes:
> > May be it would be good idea to develop some tty control driver which
> > provides a
> > possibility to change default setting of the drivers?
>
> If there is a real need for it (such as a real existing device)...
> then sure (it wouldn't be a "default setting" anymore, of course).

if there wasnt a real need to control this behavior (as in existing
devices), then i wouldnt have spawned this thread in the first place
:)

i dont muck around in serial core for fun
-mike
