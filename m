From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] serial: sunsu: add missing
 platform_driver_unregister() when module exit
Date: Sat, 04 May 2013 21:32:55 -0400 (EDT)
Message-ID: <20130504.213255.347200760283293043.davem@davemloft.net>
References: <CAPgLHd_4TH7Ur2VWtqHD3puc9eCkfHKEP9dA-ZwnxE8MtpGLww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <CAPgLHd_4TH7Ur2VWtqHD3puc9eCkfHKEP9dA-ZwnxE8MtpGLww@mail.gmail.com>
Sender: sparclinux-owner@vger.kernel.org
To: weiyj.lk@gmail.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 27 Apr 2013 18:13:16 +0800

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> We have registered platform driver when module init, and
> need unregister it when module exit.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.
