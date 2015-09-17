From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 3/4] serial: samsung: introduce
 s3c24xx_serial_rx_drain_fifo() function
Date: Thu, 17 Sep 2015 16:35:18 +0900
Message-ID: <55FA6D36.5090600@samsung.com>
References: <1442321340-28167-1-git-send-email-r.baldyga@samsung.com>
 <1442321340-28167-4-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442321340-28167-4-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

On 15.09.2015 21:48, Robert Baldyga wrote:
> This patch introduces s3c24xx_serial_rx_drain_fifo() which reads data
> from RX FIFO and writes it to tty buffer. It also checks for special
> conditions (such as 'break') and handles it. This function has been
> separated from s3c24xx_serial_rx_chars_pio() as it contains code which
> can be used also in DMA mode.
> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Thanks for splitting the code. It looks good but I don't feel
experienced enough in the driver internals to give a review tag. :)

Best regards,
Krzysztof
