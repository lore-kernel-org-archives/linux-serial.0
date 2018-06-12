From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] tty: serial: add error handling for try_module_get
Date: Tue, 12 Jun 2018 11:23:29 +0300
Message-ID: <CAHp75VdtvNsQt16eb_OwGoBVTcDNEF0=E8OzqM-kHV4U6Tka=Q@mail.gmail.com>
References: <1528779046-42341-1-git-send-email-jiazhouyang09@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528779046-42341-1-git-send-email-jiazhouyang09@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, kgdb-bugreport@lists.sourceforge.net, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 12, 2018 at 7:50 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When try_module_get fails, the lack of error-handling code may
> cause unexpected results.

What results? What is recovery approach here?
How printing message change a behaviour?

> This patch adds error-handling code after calling try_module_get.

> +       if (!kgdb_connected) {
> +               if (!try_module_get(THIS_MODULE))
> +                       printk(KERN_ERR "kgdboc: cannot get module.\n");

So, what's wrong with pr_err() ?

> +       }

-- 
With Best Regards,
Andy Shevchenko
