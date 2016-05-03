From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH stable] serial: samsung: Reorder the sequence of clock
 control when call s3c24xx_serial_set_termios()
Date: Tue, 3 May 2016 12:06:19 +0200
Message-ID: <20160503100619.GA3956@kozik-lap>
References: <1462191907-27403-1-git-send-email-k.kozlowski@samsung.com>
 <20160502182459.GA11129@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160502182459.GA11129@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, stable@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Mon, May 02, 2016 at 11:24:59AM -0700, Greg Kroah-Hartman wrote:
> On Mon, May 02, 2016 at 02:25:07PM +0200, Krzysztof Kozlowski wrote:
> > From: Chanwoo Choi <cw00.choi@samsung.com>
> > 
> > commit b8995f527aac143e83d3900ff39357651ea4e0f6 upstream
> 
> This isn't in Linus's tree yet, so we can't take this into any -stable
> trees yet.  Please wait for that to happen, can you resend this when
> that happens?

Of course, no problem. I will resend this.

Best regards,
Krzysztof
