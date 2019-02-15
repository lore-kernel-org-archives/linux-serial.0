From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2] tty: serial: meson_uart: Add support for kernel debugger
Date: Fri, 15 Feb 2019 15:15:56 -0800
Message-ID: <7htvh4iqxf.fsf@baylibre.com>
References: <86k1ibv74r.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86k1ibv74r.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Julien Masson <jmasson@baylibre.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Julien Masson <jmasson@baylibre.com> writes:

> The kgdb invokes the poll_put_char and poll_get_char when communicating
> with the host. This patch implement the serial polling hooks for the
> meson_uart to be used for KGDB debugging over serial line.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>

Looks good, and very useful thanks!

I'm adding this to a testing branch which will get included into the
'integ' branch of my amlogic tree for some broader testing.

Kevin
