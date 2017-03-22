From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/2] serial: Add name field to uart_port
Date: Wed, 22 Mar 2017 20:46:58 +0200
Message-ID: <CAHp75VdhHj-7Utganxo1YnSABmnM5KC+bVJe2KgXx65hNHNGng@mail.gmail.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321133636.8814-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
> This series adds name attribute to uart_port struct inorder to store
> name of the tty port that will help in identify different uart
> instances.
> This patch series is based on discussion here[1].

Please, use versioning for the series. This AFAIU should be v3, and
next (which is expecting based on comments) would be v4.

> [1] https://www.spinics.net/lists/arm-kernel/msg569188.html

-- 
With Best Regards,
Andy Shevchenko
