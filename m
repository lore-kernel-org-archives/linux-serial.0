From: Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2 0/2] tty: erase buffers when the kernel is done with
 it.
Date: Wed, 10 Oct 2018 20:20:06 +0200
Message-ID: <c54d108b-729a-5866-53d1-26f2e7d0db2b@gmail.com>
References: <20181004180614.25619-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004180614.25619-1-gregkh@linuxfoundation.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build, gmazyland@gmail.com, torvalds@linux-foundation.org, w@1wt.eu, Daniel Zatovic <daniel.zatovic@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 04/10/2018 20:06, Greg Kroah-Hartman wrote:
> azlig and Milan Broz reported that when the tty layer is done with a
> buffer, the data can hang around in it for a very long time.  That
> sometimes can "leak" to userspace under some conditions.
> 
> Because of this, just zero out the data after the tty layer is finished
> with it, for buffers that we "think" should be zeroed out.
> 
> v2 - addressed some review comments on the 2/2 patch.

Hello Greg,

together with our intern we re-tested both patches and it fixes the reported problem,
so, if it helps anything, you can add

Tested-by: Milan Broz <gmazyland@gmail.com>
Tested-by: Daniel Zatovic <daniel.zatovic@gmail.com>

Do you plan to add this to linux-next?

Thanks!
Milan

> 
> Greg Kroah-Hartman (1):
>   tty: wipe buffer if not echoing data
> 
> Linus Torvalds (1):
>   tty: wipe buffer.
> 
>  drivers/tty/n_tty.c      | 20 +++++++++++++++++---
>  drivers/tty/tty_buffer.c |  6 +++++-
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
