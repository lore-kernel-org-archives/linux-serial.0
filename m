From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] TTY/JSM coding style fixes
Date: Mon, 6 Nov 2017 11:16:47 -0200
Message-ID: <03d135ce-f5d6-405b-6ea3-4cf3dd8f79a4@linux.vnet.ibm.com>
References: <cover.1509853735.git.gimcuan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509853735.git.gimcuan@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gimcuan Hui <gimcuan@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/05/2017 03:06 AM, Gimcuan Hui wrote:
> This patch set fixes several warnings and errors reported
> by checkpatch.pl.
> 
> Gimcuan Hui (5):
>   tty: serial: jsm: change the type of local variable
>   tty: serial: jsm: add blank line after declarations
>   tty: serial: jsm: delete space between function name and '('
>   tty: serial: jsm: fix coding style
>   tty: serial: jsm: add space before the open parenthesis '('
> 
>  drivers/tty/serial/jsm/jsm_tty.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Thanks for the fixes Gimcuan!

For the entire series:

Acked-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
