From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 0/3] serial: 8250_early: simplify serial_putc()
Date: Fri, 30 Oct 2015 09:41:22 -0400
Message-ID: <56337382.8060901@hurleysoftware.com>
References: <1446172745-5115-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446172745-5115-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 10/29/2015 10:39 PM, Masahiro Yamada wrote:
> Changes in v3:
>    - Split into three patches.
>    - Confirm the empty TX only after sending each character.
>
> Changes in v2:
>    - split into two patches
>
> Masahiro Yamada (3):
>    serial: 8250_early: do not save and restore IER in write callback
>    serial: 8250_early: confirm empty transmitter after sending characters
>    serial: 8250_early: squash wait_for_xmitr() into serial_putc()
>
>   drivers/tty/serial/8250/8250_early.c | 24 ++++--------------------
>   1 file changed, 4 insertions(+), 20 deletions(-)

For series

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
