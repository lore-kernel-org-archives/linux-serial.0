From: Alexander Shi <alexandershi@nanometrics.ca>
Subject: Unreliable register being read in max310x UART driver
Date: Mon, 2 Nov 2015 10:30:18 -0500
Message-ID: <CAESxSQs8f56+EsMtoJLJJGkfRfzGQ+RsCFs2AWP6yG9O0NqdMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: James Nuss <jamesnuss@nanometrics.ca>, shc_work@mail.ru
List-Id: linux-serial@vger.kernel.org

Hello all,



The datasheet for MAX3107 UART
(http://datasheets.maximintegrated.com/en/ds/MAX3107.pdf) was updated
in February 2015 with a notice that the RxFIFOLvl register may be
inaccurate if read while being updated. The respective max310x.c
driver actively makes use of the RxFIFOLvl register, but has not been
updated since the notice was posted. Does anyone have a workaround to
this bug?



The notice was phrased as follows:

=E2=80=9CThe RxFIFOLvl register represents the current number of words =
in the
receive FIFO whenever the receive UART is idle. When the receive UART
actively receives characters, the value in this register can sometimes
be inaccurate if this register is read at the same time that the
receive UART updates the receive FIFO. To manage the receive FIFO even
when the receive UART is active, do not use this register to determine
receive FIFO state. Use the RFIFOEmptyInt bit, the RxTrgInt bit, and
the RTimeOut bit instead.=E2=80=9D



Thanks,

Alex
