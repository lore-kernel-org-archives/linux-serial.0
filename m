From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] serial: Remove orphaned header sc26198.h
Date: Tue, 21 Aug 2012 18:43:12 +0200
Message-ID: <1345567392.4564.30.camel@x61.thuisdomein>
References: <1345564193-25994-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345564193-25994-1-git-send-email-shc_work@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2012-08-21 at 19:49 +0400, Alexander Shiyan wrote:
> This header was used by the driver "stallion", but the driver has
> been removed as a result of migration 2.4 -> 2.6 and the header is
> still present in the system and is not currently used by any driver.
> We can safely remove it.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  include/linux/sc26198.h |  533 -----------------------------------------------

commit afbaade3dc99838a0c39699bea175674f27322a1 ("delete seven tty
headers"), in - I think - tty.git's tty-next branch, already deleted
this and six other headers.

>  1 files changed, 0 insertions(+), 533 deletions(-)
>  delete mode 100644 include/linux/sc26198.h


Paul Bolle
