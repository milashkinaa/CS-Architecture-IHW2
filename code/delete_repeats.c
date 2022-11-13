void delete_repeats(char* str) {
    char* p1, *p2;
    for (p1 = p2 = str; *p1; *p1 = *p2) {
        if(*p2 != *(p2 + 1))
            ++p1;
        ++p2;
    }
}