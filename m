From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Date: Wed, 3 Jul 2019 15:27:11 +0200
Message-ID: <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703072435.34152-1-je.yen.tam@ni.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jeyentam <je.yen.tam@ni.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03.07.19 09:24, jeyentam wrote:

Hi,

besides what Greg already said:

>  /* UART Port Control Register */> -#define NI8430_PORTCON	0x0f> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
Can we have that renaming as a separate patch, to ease review ?

And what about introducing a config sym for the new device specific
stuff ? These devices seem to be pretty rare - never seen them in
embeded world, where we do need to care of kernel size.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
