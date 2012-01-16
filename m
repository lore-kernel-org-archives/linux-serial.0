From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] TTY: fix UV serial console regression
Date: Mon, 16 Jan 2012 14:28:11 +0100
Message-ID: <4F1425EB.6050703@gmail.com>
References: <4EDE988B.6010501@suse.cz> <1326405315-6601-1-git-send-email-jslaby@suse.cz> <20120112234132.0a973cb9@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120112234132.0a973cb9@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.cz>, gregkh@suse.de, Arnd Bergmann <arnd@arndb.de>, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "3.0 3.1 3.2" <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 01/13/2012 12:41 AM, Alan Cox wrote:
>> Unless there is some bad race in the code, the hardware seems to
>> be pretty broken. Otherwise pure MSR read should not cause such a
>> bug, or?
> 
> UV serial being what actual hardware and system ?

What exact paramteres are you interested in? dmidecode on this machine
says it's an Altix XE310.

thanks,
-- 
js
