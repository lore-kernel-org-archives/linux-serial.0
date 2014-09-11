From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3.17-rc3] serial: amba-pl011: Use container_of() to get
 uart_amba_port
Date: Thu, 11 Sep 2014 07:25:29 -0400
Message-ID: <541186A9.902@hurleysoftware.com>
References: <1409745115-1423-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409745115-1423-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/03/2014 07:51 AM, Daniel Thompson wrote:
> Universally adopt container_of() for all pointer conversion from
> uart_port to uart_amba_port.

Thanks.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> ---
> 
> Notes:
>     This patch was written after a review comment made by Peter Hurley in
>     response to code that is no longer needed.  However I'd already written
>     it before I realized the code was no longer needed and it still appears
>     to be a sensible, if rather minor, bit of modernization.
>     
> 
>  drivers/tty/serial/amba-pl011.c | 54 +++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 18 deletions(-)
