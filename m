From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: Device to write to all (serial) consoles
Date: Thu, 8 Aug 2019 16:52:24 +0200
Message-ID: <7a3cecc9-fbf0-8ab4-f838-3e9ccb5f4e73@metux.net>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel@molgen.mpg.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Donald Buczek <buczek@molgen.mpg.de>
List-Id: linux-serial@vger.kernel.org

On 02.08.19 15:23, Paul Menzel wrote:

> Does a device exist, or can a device be configured so you can write to
> all (serial) consoles from user space?

Why not just writing a little program that listens on a pipe or a pty
and writes out everything to all the tty's you want ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
