From: Alan Cox <alan@linux.intel.com>
Subject: Re: [RFC] With 8250 Designware UART, if writes to the LCR failed
 the kernel will hung up
Date: Mon, 09 Mar 2015 13:32:19 +0000
Message-ID: <1425907939.3838.182.camel@linux.intel.com>
References: <54F96F5B.2090601@huawei.com>
	 <54F9DACA.3020103@hurleysoftware.com>
	 <CAD7vxxJXEz8KfXd9fBjkxTi5Nnjyw0=wwvbw5qCSwCMbBd64eA@mail.gmail.com>
	 <54FD4779.3020902@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54FD4779.3020902@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "long.wanglong" <long.wanglong@huawei.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Zhang Zhen <zhenzhang.zhang@huawei.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tim Kryger <tim.kryger@linaro.org>, gregkh@linuxfoundation.org, jamie@jamieiles.com, arnd@arndb.de, shenjiangjiang@huawei.com, Wang Kai <morgan.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

> Maybe the next release of the board we will upgrade the serial block to the new version.
> but the issue is that how we circumvent this problem in kernel?

What is the official vendor workaround ?

Alan
