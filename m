From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: RCU stall in 8250 serial driver Linux 4.15-rc1
Date: Wed, 17 Jan 2018 18:05:20 +0100
Message-ID: <20180117170520.GA12606@kroah.com>
References: <CAASgV=tHtf88=h-wtUrnoC74M6BEnNXcCg8d3DyWJfx21dnLYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAASgV=tHtf88=h-wtUrnoC74M6BEnNXcCg8d3DyWJfx21dnLYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shankara Pailoor <sp3485@columbia.edu>
Cc: jslaby@suse.com, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 17, 2018 at 08:53:06AM -0800, Shankara Pailoor wrote:
> Hi,
> 
> Syzkaller found the following rcu stall report in Linux 4.15-rc1:
> https://pastebin.com/NyZ9JdRv
> 
> The following C program reproduces it: https://pastebin.com/gqwDWWpA
> 
> Configs Here: https://pastebin.com/v6M3iKi1

I don't visit random web sites for random bugs. Please include all of
the information in the email itself.

thanks,

greg k-h
