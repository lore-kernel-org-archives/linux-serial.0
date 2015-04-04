From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 0/3] tty: eliminate 64 byte stack buffers passed to tty_name
Date: Fri, 03 Apr 2015 20:20:41 -0400
Message-ID: <551F2E59.5080503@hurleysoftware.com>
References: <1427810160-15779-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1427810160-15779-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-input-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/31/2015 09:55 AM, Rasmus Villemoes wrote:
> All users of tty_name pass the return value directly to a printf
> function, so we might as well use tty->name directly instead of
> copying it to a user-supplied (stack) buffer.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

