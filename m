From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Is 115200 still the maximum baudrate?
Date: Thu, 2 Nov 2017 13:13:55 -0400
Message-ID: <20171102171355.onz27qoczedq7jpv@thunk.org>
References: <d712888f-3b91-76c5-b949-407b0c072bcf@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d712888f-3b91-76c5-b949-407b0c072bcf@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 02, 2017 at 04:42:56PM +0100, Paul Menzel wrote:
> 
> The Linux serial console documentation [1] says that 115200 is the maximum
> supported baudrate.
> 
> > The maximum baudrate is 115200.
> 
> Is that still accurate? If yes, where should I look to support higher
> values?

See the setserial man page and the spd_* options:

spd_hi
    Use 57.6kb when the application requests 38.4kb. This parameter
    may be specified by a non-privileged user.
     
spd_vhi
    Use 115kb when the application requests 38.4kb. This parameter may
    be specified by a non-privileged user.
    
spd_shi
    Use 230kb when the application requests 38.4kb. This parameter may
    be specified by a non-privileged user.

spd_warp
    Use 460kb when the application requests 38.4kb. This parameter may
    be specified by a non-privileged user.

						- Ted
