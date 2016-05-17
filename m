From: Alan <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] tty/serial: to support 8250 earlycon can be enabled
 independently
Date: Tue, 17 May 2016 11:11:19 +0100
Message-ID: <20160517111119.1b4daa57@lxorguk.ukuu.orguk>
References: <1463398558-6636-1-git-send-email-thunder.leizhen@huawei.com>
	<5739E9DC.3060805@hurleysoftware.com>
	<573AB623.2070300@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573AB623.2070300@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

> > I'm confused; you want the possibility of earlycon but _not_ a
> > normal serial console?  
> Our downstream customers want add some private functions into
> 8250.ko. So that, we can not pre-build the 8250 driver into Image.

The starting point would be to share that functionality with the
community and look at how it can be merged nicely. 

Alan
