From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3] use callbacks to access UART_DLL/UART_DLM
Date: Fri, 18 Dec 2015 08:42:31 -0800
Message-ID: <56743777.5060304@hurleysoftware.com>
References: <5672D89A.4090307@laposte.net>
 <yw1xoadpcbbn.fsf@unicorn.mansr.com> <5672F9C9.1010601@laposte.net>
 <5673E3FD.8080001@laposte.net> <56742F23.5010501@hurleysoftware.com>
 <567436E5.8020607@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <567436E5.8020607@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>, Jon Anders Haugum <jonah@omegav.ntnu.no>
List-Id: linux-serial@vger.kernel.org

On 12/18/2015 08:40 AM, Sebastian Frias wrote:
> Some UART HW has a single register combining UART_DLL/UART_DLM
> (this was probably forgotten in the change that introduced the
> callbacks, commit b32b19b8ffc05cbd3bf91c65e205f6a912ca15d9)
> 
> Fixes: b32b19b8ffc0 ("[SERIAL] 8250: set divisor register correctly ...")

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
