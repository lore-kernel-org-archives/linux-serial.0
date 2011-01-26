From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 2/2] tty: serial: altera_uart: add devicetree support
Date: Wed, 26 Jan 2011 19:18:30 +0100
Message-ID: <20110126181829.GD29757@distanz.ch>
References: <1295966417-11306-1-git-send-email-tklauser@distanz.ch> <1295967457-11876-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1295967457-11876-1-git-send-email-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2011-01-25 at 15:57:37 +0100, Tobias Klauser <tklauser@distanz.ch> wrote:
> Allow to retreive resources from a device tree (currently used in the
> out-of-tree nios2 architecture port only).
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/tty/serial/altera_uart.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)

Please disregard this patch. The driver will need more changes to
properly support retreiving everything it needs from device tree.

Sorry for the noise.
