From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable] serial: samsung: Reorder the sequence of clock
 control when call s3c24xx_serial_set_termios()
Date: Mon, 2 May 2016 11:24:59 -0700
Message-ID: <20160502182459.GA11129@kroah.com>
References: <1462191907-27403-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462191907-27403-1-git-send-email-k.kozlowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, stable@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Mon, May 02, 2016 at 02:25:07PM +0200, Krzysztof Kozlowski wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> commit b8995f527aac143e83d3900ff39357651ea4e0f6 upstream

This isn't in Linus's tree yet, so we can't take this into any -stable
trees yet.  Please wait for that to happen, can you resend this when
that happens?

thanks,

greg k-h
