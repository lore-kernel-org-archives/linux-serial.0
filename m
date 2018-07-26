From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: core: stop passing NULL in uart_resume_port
Date: Thu, 26 Jul 2018 17:04:45 +0300
Message-ID: <CAHp75VeuCQ+R-rK+sYbZM_ED4R5aXSXy_QiAOPd4wE7FmBxX2Q@mail.gmail.com>
References: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
 <20180726093620.3876-1-hu1.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726093620.3876-1-hu1.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Hu <hu1.chen@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 26, 2018 at 12:36 PM, Chen Hu <hu1.chen@intel.com> wrote:
> Is it better to modify the DesignWare 8250 driver directly? Or do you think is this really an issue?

I have checked all of the users of do_termios in 8250 and only DW
bails out on old == NULL.

So, send a patch against 8250_dw with detailed explanation why it's
wrong (use case, examples of wrong output, etc) and how you fix it.
Describe any potential side effects (b/c it's a new behaviour).


-- 
With Best Regards,
Andy Shevchenko
