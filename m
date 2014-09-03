From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/26] locking: Add non-fatal spin lock assert
Date: Wed, 3 Sep 2014 11:27:23 +0200
Message-ID: <20140903092723.GA4783@worktop.ger.corp.intel.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
 <1409693975-1028-14-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409693975-1028-14-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 02, 2014 at 05:39:22PM -0400, Peter Hurley wrote:
> Provide method for non-essential or non-critical code to warn of
> invariant errors.
> 
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  include/linux/spinlock.h         | 1 +
>  include/linux/spinlock_api_smp.h | 1 +
>  include/linux/spinlock_api_up.h  | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 3f2867f..8a9aaf1 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -394,6 +394,7 @@ static inline int spin_can_lock(spinlock_t *lock)
>  }
>  
>  #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
> +#define warn_not_spin_locked(lock)	warn_not_raw_spin_locked(&(lock)->rlock)
>  
>  /*
>   * Pull the atomic_t declaration:
> diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
> index 42dfab8..0ddd499 100644
> --- a/include/linux/spinlock_api_smp.h
> +++ b/include/linux/spinlock_api_smp.h
> @@ -18,6 +18,7 @@
>  int in_lock_functions(unsigned long addr);
>  
>  #define assert_raw_spin_locked(x)	BUG_ON(!raw_spin_is_locked(x))
> +#define warn_not_raw_spin_locked(x)	WARN_ON_ONCE(!raw_spin_is_locked(x))

No we should remove assert_spin_locked() not add to it. Use
lockdep_assert_held() instead.
