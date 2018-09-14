From: Jiri Slaby <jslaby@suse.cz>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_Re:_[PATCH]_tty:_max3100:_Fix_oop?=
 =?UTF-8?Q?s_while_'cat/proc/tty/driver/ttyMAX'?=
Date: Fri, 14 Sep 2018 13:28:11 +0200
Message-ID: <df806986-3133-4c94-f256-94788af78752@suse.cz>
References: <201809131432456792094@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201809131432456792094@zte.com.cn>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: chen.lin5@zte.com.cn
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/13/2018, 08:32 AM, chen.lin5@zte.com.cn wrote:
>        
> 
> but 'get_mctrl' is already protected by  the upper layer by spin lock,
> so, will the races happen?
> 
> 
> for example: in /drivers/tty/serial/serial_core.c 
> 
>               spin_lock_irq(&uport->lock);
> 
>               result |= uport->ops->get_mctrl(uport);
> 
>               spin_unlock_irq(&uport->lock);

Right, but creation and destroy of the workqueue is not locked as far as
I can see. Am I missing something?

thanks,.
-- 
js
suse labs
