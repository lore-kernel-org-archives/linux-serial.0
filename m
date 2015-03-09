From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [RFC] With 8250 Designware UART, if writes to the LCR failed the
 kernel will hung up
Date: Mon, 9 Mar 2015 07:36:21 -0700
Message-ID: <CAD7vxxJvL61BjD9AMBF34Y8xnY+D-umuWLUq8Dh7ZbSm5tCE9w@mail.gmail.com>
References: <54F96F5B.2090601@huawei.com>
	<54F9DACA.3020103@hurleysoftware.com>
	<CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>
	<54FD4779.3020902@huawei.com>
	<1425907939.3838.182.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425907939.3838.182.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: "long.wanglong" <long.wanglong@huawei.com>, Peter Hurley <peter@hurleysoftware.com>, Zhang Zhen <zhenzhang.zhang@huawei.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tim Kryger <tim.kryger@linaro.org>, gregkh@linuxfoundation.org, Jamie Iles <jamie@jamieiles.com>, Arnd Bergmann <arnd@arndb.de>, shenjiangjiang@huawei.com, Wang Kai <morgan.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 9, 2015 at 6:32 AM, Alan Cox <alan@linux.intel.com> wrote:
>> Maybe the next release of the board we will upgrade the serial block to the new version.
>> but the issue is that how we circumvent this problem in kernel?
>
> What is the official vendor workaround ?

They introduced a UART_16550_COMPATIBLE option for the IP which should
be selected.

If configured, writes to the LCR are allowed even if it is "busy" so
there is no need to retry.

More importantly there is no possibility of failing to write the LCR
after numerous retries.

-Tim
