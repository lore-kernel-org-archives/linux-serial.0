From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] drivers: tty: serial: amba-pl011: use generic ops
 request/release port
Date: Mon, 29 Jul 2019 16:46:39 +0200
Message-ID: <e831001d-0f9c-800c-94d5-7e767fa4fc5a@metux.net>
References: <1564411445-26933-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1564411445-26933-1-git-send-email-info@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 29.07.19 16:44, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> Reduce boilerplate by using generic implementation of the trivial
> request_port/release_port operations. For that to work, we have to
> set the mapsize field accordingly.


Shit! Forget it. Somehow cherry-picked the wrong commit ID and forgot
to check before posting. That wasn't supposed to be sent out yet.

Sorry for the noise.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
