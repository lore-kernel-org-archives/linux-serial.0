From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 2/2] serial: 8250pci: Recast inb return value
Date: Tue, 17 Aug 2010 12:09:41 +0200
Message-ID: <4C6A5FE5.2090206@monstr.eu>
References: <1282031947-16483-1-git-send-email-monstr@monstr.eu>	<1282031947-16483-2-git-send-email-monstr@monstr.eu> <20100817110435.45e6ed8b@lxorguk.ukuu.org.uk>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51464 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab0HQKJp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Aug 2010 06:09:45 -0400
In-Reply-To: <20100817110435.45e6ed8b@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 17 Aug 2010 09:59:07 +0200
> Michal Simek <monstr@monstr.eu> wrote:
> 
>> inb returns u8 that's why is necessary to do recast.
> 
> ret is an int, inb returns a u8, neither are pointers and the cast
> required is implict and defined by the spec.

ok. I am using gcc 4.1.2 which is likely the reason why I see that warnings.

Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
