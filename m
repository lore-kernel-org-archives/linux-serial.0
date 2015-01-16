From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2] n_tty: Fix unordered accesses to lockless read buffer
Date: Fri, 16 Jan 2015 10:55:18 -0500
Message-ID: <54B93466.9010601@hurleysoftware.com>
References: <1421113668-20468-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421113668-20468-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Denis Du <dudenis2000@yahoo.ca>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Christian Riesch <christian.riesch@omicron.at>
List-Id: linux-serial@vger.kernel.org

On 01/12/2015 08:47 PM, Peter Hurley wrote:
> Add commit_head buffer index, which the producer-side publishes
> after input processing in non-canon mode. This ensures the consumer-side
> observes correctly-ordered writes in non-canonical mode (ie., the buffer
> data is written before the buffer index is advanced). Fix consumer-side
> uses of read_cnt() to use commit_head instead.
> 
> Add required memory barriers to the tail index to guarantee
> the consumer-side has completed the loads before the producer-side
> begins writing new data. Open-code the producer-side receive_room()
> into the i/o loop.

Hi Greg,

Please don't apply this. I've been testing a v3 series that I should be
able to get to you today.

Regards,
Peter Hurley
