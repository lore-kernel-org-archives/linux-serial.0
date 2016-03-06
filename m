From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_ingenic: Remove global variable
Date: Sat, 5 Mar 2016 19:01:22 -0800
Message-ID: <20160306030122.GB25405@kroah.com>
References: <1457222155-27601-1-git-send-email-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457222155-27601-1-git-send-email-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Jiri Slaby <jslaby@suse.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Mar 06, 2016 at 12:55:55AM +0100, Paul Cercueil wrote:
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I can't take patches without a changelog entry :(
