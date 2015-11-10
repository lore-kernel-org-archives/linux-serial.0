From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Nov 10 (8250_mid.c)
Date: Tue, 10 Nov 2015 10:12:26 -0800
Message-ID: <5642338A.1000502@infradead.org>
References: <20151110131914.297a5e60@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151110131914.297a5e60@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 11/09/15 18:19, Stephen Rothwell wrote:
> Hi all,
> 
> Please do *not* add any material intended for v4.5 to your linux-next
> included branches until after v4.4-rc1 has been released.
> 
> Changes since 20151109:
> 

on x86_64:

drivers/built-in.o: In function `mid8250_set_termios':
8250_mid.c:(.text+0x10169a): undefined reference to `rational_best_approximation'

CONFIG_RATIONAL is not enabled.  Just need to select it I think.


-- 
~Randy
