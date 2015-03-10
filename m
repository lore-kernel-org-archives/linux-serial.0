From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC] With 8250 Designware UART, if writes to the LCR failed
 the kernel will hung up
Date: Tue, 10 Mar 2015 09:25:04 -0400
Message-ID: <54FEF0B0.6010002@hurleysoftware.com>
References: <54F96F5B.2090601@huawei.com>	<54F9DACA.3020103@hurleysoftware.com>	<CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>	<54FD4779.3020902@huawei.com>	<1425907939.3838.182.camel@linux.intel.com>	<CAD7vxxJvL61BjD9AMBF34Y8xnY+D-umuWLUq8Dh7ZbSm5tCE9w@mail.gmail.com>	<1425913502.3838.185.camel@linux.intel.com> <CAD7vxx+WYgOujpTAxXsUmcr8T4zHS9MYfwrWu8hV2t=TudLamQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD7vxx+WYgOujpTAxXsUmcr8T4zHS9MYfwrWu8hV2t=TudLamQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Alan Cox <alan@linux.intel.com>
Cc: "long.wanglong" <long.wanglong@huawei.com>, Zhang Zhen <zhenzhang.zhang@huawei.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org, Jamie Iles <jamie@jamieiles.com>, Arnd Bergmann <arnd@arndb.de>, shenjiangjiang@huawei.com, Wang Kai <morgan.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

On 03/09/2015 10:47 PM, Tim Kryger wrote:
> The current workaround of clearing fifos and retrying a fixed number
> of times isn't ideal but I'm not sure what else can be done given the
> way this hardware works.

But hanging the machine is not an acceptable outcome.

Since the hang stems from the printk while already holding the port->lock,
until I can fix the console write, I think it's best to comment out
the dev_err() with a FIXME note.

The 8250 console write already checks port->sysrq to allow printk from
within the driver so this solution just needs to be generalized.
And there are debug uses of printk() from within the driver that are just
as broken, so this isn't the only use case. (I want to do something
similar for the au_serial-* i/o accessors too).

Regards,
Peter Hurley
