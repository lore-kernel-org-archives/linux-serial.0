From: Chen Hu <hu1.chen@intel.com>
Subject: Re: [PATCH] serial: core: stop passing NULL in uart_resume_port
Date: Thu, 26 Jul 2018 17:36:20 +0800
Message-ID: <20180726093620.3876-1-hu1.chen@intel.com>
References: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.shevchenko@gmail.com
Cc: Chen Hu <hu1.chen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


Hi Andy,
Thanks the feedback.

Is it better to modify the DesignWare 8250 driver directly? Or do you think is this really an issue?

Thanks
Chen Hu
