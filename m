From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2] use callbacks to access UART_DLL/UART_DLM
Date: Fri, 18 Dec 2015 08:34:12 -0800
Message-ID: <56743584.50500@hurleysoftware.com>
References: <5672D89A.4090307@laposte.net>
 <yw1xoadpcbbn.fsf@unicorn.mansr.com> <5672F9C9.1010601@laposte.net>
 <5673E3FD.8080001@laposte.net> <56742F23.5010501@hurleysoftware.com>
 <56743405.8020408@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56743405.8020408@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Frias <sf84@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>, Jon Anders Haugum <jonah@omegav.ntnu.no>
List-Id: linux-serial@vger.kernel.org

On 12/18/2015 08:27 AM, Sebastian Frias wrote:
> On 12/18/2015 05:06 PM, Peter Hurley wrote:
>>> -    unsigned char old_dll, old_dlm, old_lcr;
>>> +    unsigned char old_lcr;
>>>       unsigned int id;
>>> +    unsigned int old_dl;
>>
>>     unsigned int id, old_dl;
> 
> Ok, thanks for your comments.
> By the way, should I just do:
> 
> -    unsigned char old_dll, old_dlm, old_lcr;
> +    unsigned char old_lcr, old_dl;
> 
> ?

The divisor is a 16-bit value.
